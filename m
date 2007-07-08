From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Structures from -include are "weak"
Date: Sun, 8 Jul 2007 07:06:09 +0100
Message-ID: <20070708060609.GE21668@ftp.linux.org.uk>
References: <1183865570.12651.18.camel@gx> <20070708054218.GD21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54921 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbXGHGGK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 02:06:10 -0400
Content-Disposition: inline
In-Reply-To: <20070708054218.GD21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Jul 08, 2007 at 06:42:18AM +0100, Al Viro wrote:
> {
> 	struct st;
> 	struct st *p;
> 	...
> 	struct st {....} x;
> 	...
> }
> 
> will make p a pointer to struct st from that scope.  If you omit it,
> p will be a pointer to struct st from the outer scope and x will have
> a different type.  Too late beginning of file scope, perhaps?

Gyah...  So it is.  We put the stuff from -include into builtin_scope
and start the file scope only in __sparse().

See if adding
int is_outer_scope(struct scope *scope)
{
	if (scope == block_scope)
		return 0;
	if (scope == &builtin_scope && block_scope->next == &builtin_scope)
		return 0;
	return 1;
}
to scope.c and replacing
		sym = lookup_symbol(token->ident, NS_STRUCT);
		if (!sym ||
		    (sym->scope != block_scope &&
		     (match_op(token->next,';') || match_op(token->next,'{')))) {
with
		sym = lookup_symbol(token->ident, NS_STRUCT);
		if (!sym ||
		    (is_outer_scope(sym->scope) &&
		     (match_op(token->next,';') || match_op(token->next,'{')))) {
in parse.c:struct_union_enum_specifier() would fix all problems of that kind.
