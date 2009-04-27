From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Mon, 27 Apr 2009 10:45:17 -0700
Message-ID: <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com>
References: <49F4C99A.7020208@garzik.org>
	 <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>
	 <49F588BA.4060503@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:5470 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbZD0RpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 13:45:18 -0400
Received: by yx-out-2324.google.com with SMTP id 3so32933yxj.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 10:45:18 -0700 (PDT)
In-Reply-To: <49F588BA.4060503@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Apr 27, 2009 at 3:28 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Use of test-parsing eliminates my code as a factor -- which was why I
> mentioned it.
>
> Oh well, I will figure it out.

Let me take a look at your code as well. Maybe I can spot some thing.

>
> linearized output is too low level for LLVM in several cases. =A0The =
shifts in
> linearize_load_gen() and linearize_store_gen() get in the way, for ex=
ample.
> =A0Having sparse calculate struct offsets itself is also not desirabl=
e: in
> order to use LLVM's getelementptr instruction, you should instead giv=
e LLVM
> the type information and member indices, and let it figure out the ad=
dress
> calculation from there.

Right. I think GET_ELEMENT_PTR is the only part missing. I think it is
a relative small change to preserve the structure laid, comparing to re=
writing
everything.

BTW, I don't think linearize lost that structure information. It
happens way before
linearize stage. Sparse converts the structure member access into void =
pointer
add very early on. If you want to preserve that information,
you need to change more than just linearize code. So linearize is not t=
he
blocking factor here. It needs upstream change as well.

> Thus, use of linearize would imply having to work backwards and recre=
ate
> information lost during the linearization.

Or, we can teach sparse to preserve that information in the linearize l=
evel.

> The general idea with LLVM bitcode is to pass it type information, an=
d it
> will ensure that bitfields are handled properly, structs are laid out=
 and
> padded properly, function return types handled, etc. =A0LLVM handles =
all the
> address generation for us, once we give it enough type info.

Currently the linearize instruction already has the C type information.=
 David's
compiler back end needs that. We still need the structure laid though.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
