From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Mon, 27 Apr 2009 16:39:55 -0700
Message-ID: <70318cbf0904271639w20cc0300ge2e3ac0638c698dd@mail.gmail.com>
References: <49F4C99A.7020208@garzik.org>
	 <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>
	 <49F588BA.4060503@garzik.org>
	 <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com>
	 <49F6386D.5050809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:11450 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZD0Xj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 19:39:56 -0400
Received: by yw-out-2324.google.com with SMTP id 5so139975ywb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 16:39:55 -0700 (PDT)
In-Reply-To: <49F6386D.5050809@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Apr 27, 2009 at 3:57 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Well, I'll tell you what. =A0If you or somebody else wants to volunte=
er to
> make key sparse & linearize changes, then I will work on a linearize =
LLVM
> backend.
>
> Absent that, the motivation is lower, considering I have a current, w=
orking
> approach that does not require any upstream changes.

Unless I am missing some thing. I don't see your back end generate
GET_ELEMENT_PTR instruction in LLVM. So you should be able to use exist=
ing
linearize instruction to generate what your patch does, without up stre=
am
changes.

To generate GET_ELEMENT_PTR properly require upstream changes, but
your patch doesn't do that either.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
