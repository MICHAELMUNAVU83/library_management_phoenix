defmodule LibraryManagementWeb.BookController do
  use LibraryManagementWeb, :controller

  alias LibraryManagement.Books
  alias LibraryManagement.Books.Book
  alias LibraryManagement.Reviews.Review
  alias LibraryManagement.Reviews
  alias LibraryManagement.Repo

  def index(conn, _params) do
    books = Books.list_books()
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = Books.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case Books.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book =
      id
      |> Books.get_book!
      |> Repo.preload([:reviews])
    changeset = Review.changeset(%Review{}, %{})
    render(conn, "show.html", book: book, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    changeset = Books.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Books.get_book!(id)

    case Books.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: Routes.book_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    {:ok, _book} = Books.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: Routes.book_path(conn, :index))
  end

  def add_a_review(conn, %{"review" => review_params, "book_id" => book_id}) do
    book =
      book_id
      |> Books.get_book!()
      |> Repo.preload([:reviews])
    case Books.add_review(book_id, review_params) do
      {:ok, _review} ->
        conn
        |> put_flash(:info, "review added :)")
        |> redirect(to: Routes.book_path(conn, :show, book))
      {:error, _error} ->
        conn
        |> put_flash(:error, "review not added :(")
        |> redirect(to: Routes.book_path(conn, :show, book))
    end
  end
end
