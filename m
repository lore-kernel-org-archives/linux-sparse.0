From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 22:09:06 +0000
Message-ID: <20090319220906.GG28946@ZenIV.linux.org.uk>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com> <20090319144622.GA28946@ZenIV.linux.org.uk> <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com> <20090319191431.GD28946@ZenIV.linux.org.uk> <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com> <20090319215250.GF28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33013 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbZCSWJJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 18:09:09 -0400
Content-Disposition: inline
In-Reply-To: <20090319215250.GF28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

On Thu, Mar 19, 2009 at 09:52:50PM +0000, Al Viro wrote:
> On Thu, Mar 19, 2009 at 01:04:20PM -0700, Christopher Li wrote:
> 
> > We should stop the segfault though. I take a look at it. It seems that
> > there is a SYM_NODE with base_type is NULL. I guess in some of
> > the error path we result in an invalid AST three.
> 
> We are getting some mess with K&R declarations.  Which is bloody likely
> to be my fault; will check.

Yeah...  It's an old b0rken handling of calls for K&R + changes that exposed
that even worse.

Status quo is restored by the patch below, but it's a stopgap - e.g.
void f();
void g(void)
{
	f(0, 0);
}
will warn about extra arguments as if we had void f(void); as sparse had
been doing all along.  B0rken.

Testcase for the segfault is
void f(x, y);
void g(void)
{
	f(0, 0);
}

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/parse.c b/parse.c
index b9b96ba..87f6264 100644
--- a/parse.c
+++ b/parse.c
@@ -2323,6 +2323,7 @@ static struct token *identifier_list(struct token *token, struct symbol *fn)
 		sym->ident = token->ident;
 		token = token->next;
 		sym->endpos = token->pos;
+		sym->ctype.base_type = &incomplete_ctype;
 		add_symbol(list, sym);
 		if (!match_op(token, ',') ||
 		    token_type(token->next) != TOKEN_IDENT ||
