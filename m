From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [RFC PATCH] Fix crash in linearize_compound_statement()
Date: Mon, 7 Apr 2008 23:05:09 -0700
Message-ID: <70318cbf0804072305x9b1dacdrd25bca5094bb23d5@mail.gmail.com>
References: <1207601111.22430.28.camel@dv>
	 <70318cbf0804071455g2f15e136qab225063f7faa89f@mail.gmail.com>
	 <1207631657.3209.13.camel@rd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:36719 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYDHGFN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 Apr 2008 02:05:13 -0400
Received: by py-out-1112.google.com with SMTP id u52so2707487pyb.10
        for <linux-sparse@vger.kernel.org>; Mon, 07 Apr 2008 23:05:10 -0700 (PDT)
In-Reply-To: <1207631657.3209.13.camel@rd>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 7, 2008 at 10:14 PM, Pavel Roskin <proski@gnu.org> wrote:
>
>  I should have been more clear.  Last time I was carried away by some
>  strange messages about "return" and labels, which seemed really weird to
>  me, but less so after your explanation.
>
>  This example is made from the same original source, but this time I
>  concentrated on the crash, because that's the thing that cannot be
>  justified by any bad code.

I understand that you have your source code which sparse choked on
fixed. Good.

I am actually complaining your fix to sparse itself. It is not good enough.
You fix it in the linearize stage. That is already too late.

You should fix it in the parse and type evaluate stage, before it even reach
to the linearizer.

>
>
>  > I agree sparse should not assert on it, but not like this.
>
>  I don't quite understand why sparse is getting in this situation, but

Exactly. That is because you try to linearize the exact same function
twice due to the "typeof(bar)". Linearize the same function twice is just
plain wrong. It should never happen. Your patch just covers up the real problem
instead of fixing it.

>  That's fixed, of course.  And many other problems are fixed too, some of
>  which are user visible.  I really appreciate the usefulness of sparse.

I mean the fix in the sparse source code, not the source code which sparse
is checking. You should change sparse, when it do "typeof(function) varname",
give it a warning and skip this "varname" node all together. Later in the
linearize stage, it will not linearize the same function twice.

What your patch does is actually allowing sparse linearized a function twice.
That is going to mess up the user-define chain very badly (e.g. the PHI node
usage problem you are seeing.)

Chris
