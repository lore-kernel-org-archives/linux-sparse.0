From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 09:53:50 -0400 (EDT)
Message-ID: <1089027793.4868687.1493906030607.JavaMail.zimbra@redhat.com>
References: <20170503165518.7625-1-lrichard@redhat.com> <20170503235403.6i5za2wa526fmp6w@desk.local> <CAMHZB6Gjf5gX92yiGshRgCpCLM=xuxBkXyDQ=RQA=gx6bG3PpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbdEDNxv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 09:53:51 -0400
In-Reply-To: <CAMHZB6Gjf5gX92yiGshRgCpCLM=xuxBkXyDQ=RQA=gx6bG3PpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> From: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
> To: "Lance Richardson" <lrichard@redhat.com>
> Cc: "Linux-Sparse" <linux-sparse@vger.kernel.org>
> Sent: Wednesday, 3 May, 2017 10:29:27 PM
> Subject: Re: [PATCH v4] sparse: add support for _Static_assert
> 
> On Thu, May 4, 2017 at 1:54 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Wed, May 03, 2017 at 12:55:18PM -0400, Lance Richardson wrote:
> >> This patch introduces support for the C11 _Static_assert() construct.
> >
> > Great!
> >
> >> diff --git a/parse.c b/parse.c
> > ...
> >> index b52c6ab..f1b96cc 100644
> >> --- a/parse.c
> >> +++ b/parse.c
> >> @@ -1864,13 +1872,21 @@ static struct token *declaration_list(struct token
> >> *token, struct symbol_list **
> >>  static struct token *struct_declaration_list(struct token *token, struct
> >>  symbol_list **list)
> >>  {
> >>       while (!match_op(token, '}')) {
> >> -             if (!match_op(token, ';'))
> >> -                     token = declaration_list(token, list);
> >> -             if (!match_op(token, ';')) {
> >> -                     sparse_error(token->pos, "expected ; at end of
> >> declaration");
> >> -                     break;
> >> +             struct symbol *keyword = NULL;
> >> +
> >> +             if (token_type(token) == TOKEN_IDENT)
> >> +                     keyword = lookup_keyword(token->ident, NS_KEYWORD);
> >> +             if (keyword && keyword->op == &static_assert_op)
> >
> > Is it possible to move this test in a helper? Something like
> >         static int match_static_assert(struct token *token)
> >         {
> >                 struct symbol *keyword;
> >                 if (token_type(token) != TOKEN_IDENT)
> >                         return 0;
> >                 keyword = lookup_keyword(token->ident, NS_KEYWORD);
> >                 return keyword && keyword->op == &static_assert_op;
> >         }
> >
> >> @@ -2389,6 +2436,10 @@ static struct token * statement_list(struct token
> >> *token, struct statement_list
> >>                       }
> >>                       stmt = alloc_statement(token->pos,
> >>                       STMT_DECLARATION);
> >>                       token = external_declaration(token,
> >>                       &stmt->declaration);
> >> +             } else if (token_type(token) == TOKEN_IDENT &&
> >> +                        (keyword = lookup_keyword(token->ident,
> >> NS_KEYWORD)) &&
> >> +                        keyword->op == &static_assert_op) {
> >> +                     token = parse_static_assert(token, NULL);
> 
> There is another problem here. With a few more line of context, we have:
> >> @@ -2389,6 +2436,10 @@ static struct token * statement_list(struct token
> >> *token, struct statement_list
> >>                       }
> >>                       stmt = alloc_statement(token->pos,
> >>                       STMT_DECLARATION);
> >>                       token = external_declaration(token,
> >>                       &stmt->declaration);
> >> +             } else if (token_type(token) == TOKEN_IDENT &&
> >> +                        (keyword = lookup_keyword(token->ident,
> >> NS_KEYWORD)) &&
> >> +                        keyword->op == &static_assert_op) {
> >> +                     token = parse_static_assert(token, NULL);
> >>                }
> >>                add_statement(list, stmt);
> 
> but when the static assert matches 'stmt' is not initialized and still added
> to the statement list (with sporadic crashes).
> 

Oof, I recall noticing that but apparently forgot to do anything about it.

Thanks for the quick feedback, will incorporate in v5. 

> -- Luc
> 
