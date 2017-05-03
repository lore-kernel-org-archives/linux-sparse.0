From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 01:54:03 +0200
Message-ID: <20170503235403.6i5za2wa526fmp6w@desk.local>
References: <20170503165518.7625-1-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36606 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbdECXyH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 19:54:07 -0400
Received: by mail-wr0-f176.google.com with SMTP id l50so2132144wrc.3
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 16:54:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170503165518.7625-1-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Wed, May 03, 2017 at 12:55:18PM -0400, Lance Richardson wrote:
> This patch introduces support for the C11 _Static_assert() construct.

Great!
 
> diff --git a/parse.c b/parse.c
...
> index b52c6ab..f1b96cc 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1864,13 +1872,21 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
>  static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
>  {
>  	while (!match_op(token, '}')) {
> -		if (!match_op(token, ';'))
> -			token = declaration_list(token, list);
> -		if (!match_op(token, ';')) {
> -			sparse_error(token->pos, "expected ; at end of declaration");
> -			break;
> +		struct symbol *keyword = NULL;
> +
> +		if (token_type(token) == TOKEN_IDENT)
> +			keyword = lookup_keyword(token->ident, NS_KEYWORD);
> +		if (keyword && keyword->op == &static_assert_op)

Is it possible to move this test in a helper? Something like
	static int match_static_assert(struct token *token)
	{
		struct symbol *keyword;
		if (token_type(token) != TOKEN_IDENT)
			return 0;
		keyword = lookup_keyword(token->ident, NS_KEYWORD);
		return keyword && keyword->op == &static_assert_op;
	}

> @@ -2389,6 +2436,10 @@ static struct token * statement_list(struct token *token, struct statement_list
>  			}
>  			stmt = alloc_statement(token->pos, STMT_DECLARATION);
>  			token = external_declaration(token, &stmt->declaration);
> +		} else if (token_type(token) == TOKEN_IDENT &&
> +			   (keyword = lookup_keyword(token->ident, NS_KEYWORD)) &&
> +			   keyword->op == &static_assert_op) {
> +			token = parse_static_assert(token, NULL);

The helper can be reused here too.

But then I saw that code like:
	extern int _Static_assert;
didn't gave a warning because '_Static_assert' is not reserved
keyword as it should. And then I wonder how this can be simplified. 

For the test cases, it would also be good to add a small test using
the assert not on the top of a block (thus not where declarations
normally are).

-- Luc
