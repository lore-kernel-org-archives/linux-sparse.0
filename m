From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [RFC PATCH] Fix crash in linearize_compound_statement()
Date: Mon, 7 Apr 2008 14:55:02 -0700
Message-ID: <70318cbf0804071455g2f15e136qab225063f7faa89f@mail.gmail.com>
References: <1207601111.22430.28.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:20755 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYDGVzG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 17:55:06 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1309369wra.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Apr 2008 14:55:03 -0700 (PDT)
In-Reply-To: <1207601111.22430.28.camel@dv>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 7, 2008 at 1:45 PM, Pavel Roskin <proski@gnu.org> wrote:
>  static int x;
>  static inline void foo(void)
>  {
>     if (x)
>         x = 1;
>  }
>  static void bar(void)
>  {
>     foo();
>  }
>  static typeof(bar) quux;
>
>
>  The crash happens in linearize_compound_statement(), and I believe that
>  the reason is incorrect access to phi_node->phi_list without making sure
>  that phi_node->opcode is OP_PHI.  When processing the above program,
>  phi_node->phi_list can be OP_INLINED_CALL.

No, that is not the root cause. The root cause is you feed sparse with
bad input. typeof(bar) will give you a type of a function. Sparse just let
quux have the base type of bar function body. That is just so wrong.

>
>  I understand very little in sparse code, and I have no idea what kind of
>  fallback is needed when phi_node->opcode is not OP_PHI.
>
>  But this patch fixes the crash:

As I said before, this is not the right fix. Wish it not get applied.

I agree sparse should not assert on it, but not like this.
You should at least fix it from the typeof(bar) side, instead of try
to linearize
the same function twice.

Chris
