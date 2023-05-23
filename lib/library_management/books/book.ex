defmodule LibraryManagement.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :isbn, :integer
    field :publication_date, :date
    field :title, :string
    has_many(:reviews, LibraryManagement.Reviews.Review)

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :publication_date])
    |> validate_required([:title, :isbn, :publication_date])
  end
end
