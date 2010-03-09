From: Pavel Roskin <proski@gnu.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 09 Mar 2010 13:35:19 -0500
Message-ID: <1268159719.23196.12.camel@mj>
References: <1268097872.16227.10.camel@mj>
	 <70318cbf1003082143n15e88111haee15d2aa027c0b@mail.gmail.com>
	 <201003091446.50092.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:26706 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0CISfg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 13:35:36 -0500
In-Reply-To: <201003091446.50092.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue, 2010-03-09 at 14:46 +0100, Kamil Dudka wrote:

P.S. Sorry, I just realized I could add more useful information.  That's
the complete expr in warn_for_enum_conversions():

(gdb) p *expr
$4 = {type = EXPR_CONDITIONAL, flags = 0, op = 63, pos = {type = 7,
stream = 3, newline = 0, whitespace = 1, pos = 47, line = 897, noexpand
= 0}, ctype = 0x668bc0, {{value = 139893141633168, taint = 0, 
      enum_type = 0x7f3b6a387b10}, fvalue = 0, string = 0x7f3b69037890,
{unop = 0x7f3b69037890, op_value = 0}, {symbol = 0x7f3b69037890,
symbol_name = 0x0}, statement = 0x7f3b69037890, {left = 0x7f3b69037890, 
      right = 0x0}, {deref = 0x7f3b69037890, member = 0x0}, {base =
0x7f3b69037890, r_bitpos = 0, r_nrbits = 0}, {cast_type =
0x7f3b69037890, cast_expression = 0x0}, {conditional = 0x7f3b69037890, 
      cond_true = 0x0, cond_false = 0x7f3b6a387b10}, {fn =
0x7f3b69037890, args = 0x0}, {label_symbol = 0x7f3b69037890}, expr_list
= 0x7f3b69037890, {expr_ident = 0x7f3b69037890, field = 0x0, 
      ident_expression = 0x7f3b6a387b10}, {idx_from = 1761835152, idx_to
= 32571, idx_expression = 0x0}, {init_offset = 1761835152, init_nr =
32571, init_expr = 0x0}, {in = 0x7f3b69037890, down = 0x0, {
        ident = 0x7f3b6a387b10, index = 0x7f3b6a387b10}}}}

And that's where it happens (in the code being checked):

static int do_alg_test(const char *alg, u32 type, u32 mask)
{
        return crypto_has_alg(alg, type, mask ?: CRYPTO_ALG_TYPE_MASK) ?
               0 : -ENOENT;
}

I removed the outside conditional, and sparse would still crash on this:

crypto_has_alg(alg, type, mask ?: CRYPTO_ALG_TYPE_MASK);

but not on this:

crypto_has_alg(alg, type, mask ? mask: CRYPTO_ALG_TYPE_MASK);

Apparently, the "?:" notation is confusing sparse now.

-- 
Regards,
Pavel Roskin
