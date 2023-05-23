defmodule LibraryManagement.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LibraryManagement.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        isbn: 42,
        publication_date: ~D[2023-05-21],
        title: "some title"
      })
      |> LibraryManagement.Books.create_book()

    book
  end
end
