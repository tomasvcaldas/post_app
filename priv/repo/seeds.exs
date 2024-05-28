alias PostApp.Repo
alias PostApp.Post.Schema, as: PostSchema

post1 = %PostSchema{
  title: "First post",
  body: "This is the first post body"
}

post2 = %PostSchema{
  title: "Second post",
  body: "This is the second post body"
}

Repo.insert!(post1)
Repo.insert!(post2)

IO.puts("seeding complete")
