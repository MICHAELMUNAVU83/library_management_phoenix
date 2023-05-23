defmodule LibraryManagement.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :content, :string
    field :name, :string
    belongs_to(:book, LibraryManagement.Books.Book)

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:name, :content, :book_id])
    |> validate_required([:name, :content, :book_id])
  end
end
