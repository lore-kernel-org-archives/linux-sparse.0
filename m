From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Sun, 26 Apr 2009 23:04:19 -0700
Message-ID: <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>
References: <49F4C99A.7020208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:45720 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbZD0GEU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 02:04:20 -0400
Received: by gxk10 with SMTP id 10so4438224gxk.13
        for <linux-sparse@vger.kernel.org>; Sun, 26 Apr 2009 23:04:19 -0700 (PDT)
In-Reply-To: <49F4C99A.7020208@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Sun, Apr 26, 2009 at 1:52 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Consider this testcase:
>
> int bloo = 0;
>
> void inc_bloo(void)
> {
>        bloo += 2;
> }
>

test-linearize show:

inc_bloo:
.L0x7fc013df7010:
	<entry-point>
	load.32     %r1 <- 0[bloo]
	add.32      %r3 <- %r1, $2
	store.32    %r3 -> 0[bloo]
	ret


get_bloo:
.L0x7fc013df70a0:
	<entry-point>
	load.32     %r5 <- 0[bloo]
	ret.32      %r5

> Any idea why?  I'm not sure if this is a tree-walker bug or something from
> the parsing.  The test-parse output is below...

So obvious the parser is correct and I will blame your code :-).

This bring the points that you really should make your LLVM converter
base on the linearized byte code. Being able to convert to LLVM
byte code is actually one of my consideration when I hack on the linearized
back end back then. Look, there is even reserved an opcode for
GET_ELEMENT_PTR. If there is some thing need to change to the linearized
back end to make this happen, I am glad to do it.

But I don't want to have yet another linearized equivalent code base in
sparse. This is duplicated effort. Bugs will need to fix in both place.
I am pretty sure using the linearized back end will greatly simplify
your LLVM byte code generation.

Do you want to give it a try?

Chris
