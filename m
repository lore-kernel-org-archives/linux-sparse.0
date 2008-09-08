From: "Chris Li" <christ.li@gmail.com>
Subject: Re: Odd behaviour with OP_SCAST
Date: Mon, 8 Sep 2008 14:02:18 -0700
Message-ID: <70318cbf0809081402i7c7e80c4g9b45988b8cf2e0fc@mail.gmail.com>
References: <48C2F2BC.9030606@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:19651 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbYIHVCT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Sep 2008 17:02:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1600546rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 08 Sep 2008 14:02:19 -0700 (PDT)
In-Reply-To: <48C2F2BC.9030606@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Sep 6, 2008 at 2:14 PM, David Given <dg@cowlark.com> wrote:
> The end result is that my call statement turns into:
>
>        call        func, $0, %r3, %arg1, %arg1
>
> ...which is wrong.
>
> I assume that Clue's odd configuration is violating some assumption
> somewhere, but I'm not well-enough versed with the sparse internals to
> know where. It does seem odd to me that it's generating an OP_SCAST to
> convert the int to a double, rather than an OP_FPCAST like in the float.

Sparse assume that float and double have different size than int.
On the linearized instruction level, it does not have the full type
information any more. All it got is the size of the type. So it is
tricky to distinguish int vs float.

It generate cast to double because your third argument is a
double type.

Because the kernel does not have any floating pointer
code. Sparse did not take floating point very seriously.

The change require the instruction to have more type
information than size. I am tempting to just put a full
ctype pointer there.

Chris
