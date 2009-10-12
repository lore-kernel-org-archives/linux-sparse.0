From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] New attribute designated_init: mark a struct as requiring
	designated init
Date: Sun, 11 Oct 2009 22:18:24 -0700
Message-ID: <70318cbf0910112218j50a63148t2e044bc5451dc0cb@mail.gmail.com>
References: <20091010085732.GA10923@feather>
	 <70318cbf0910100333m128e3500vb1659a55a9f49768@mail.gmail.com>
	 <20091010160304.GA11876@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f203.google.com ([209.85.212.203]:55582 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZJLFTC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Oct 2009 01:19:02 -0400
In-Reply-To: <20091010160304.GA11876@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 10, 2009 at 9:03 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> After getting this patch reviewed, I intended to add many such
> annotations myself. =A0I have patches sitting in my local Linux tree.
> (However, I don't plan to try to get the patches accepted into Linux
> until this attribute shows up in a Sparse release, since I don't want=
 to
> make Linux require the latest Sparse from the git tree.)

I apply your patch so you can have a fair chance to pitch to the
kernel. If nobody use it, I can remove it later. I don't think you need
to wait for the patch to go into sparse release to collect feed back
from lkml.


> You *hope* that positional initialization will fail. :) =A0Some of th=
ese
> types of structures contain many fields with the same or similar type=
s,
> and initializers don't inherently contain a lot of distinguishing typ=
e
> information that helps cause type errors rather than silent failures.

I am very interested to know some precedence from the kernel commit his=
tory.
If we can find such a commit which changes the structure and breaks
other initialization due to the position initialization, it will make y=
our
case stronger as well.

> Even if the positional initialization does fail, this failure will oc=
cur
> at the time of attempting to change the structure, and many such
> failures may occur all over the tree, making such changes significant=
ly
> more difficult. =A0With the designated_init attribute, sparse will wa=
rn
> when attempting to create the structure initializer.

Without sparse, you can temporary  insert some unused strange type
into the beginning of the struct. That should cause any position initia=
lizer
fail to compile. You can then find call the call site.

> With the designated_init attribute, someone making changes to a
> structure can check that Sparse produces no warnings about positional
> initializers and then know that certain types of changes can occur
> without having to check every initializer. =A0For instance, removing =
a
> field will only require checking any initializer that initializes tha=
t
> field, and the compiler will find all of those. =A0Adding a field tha=
t can
> safely remain NULL does not require checking any initializers.

I think the initializer is just a small part of the work if you even ch=
ange
the structure. You need to make sure the *code* use these C struct
actually works as expected.

> (As an aside, though: any fundamental reason why we use that error-pr=
one
> approach rather than allocating one extra byte and NUL-terminating
> idents? =A0Then we could drop the (larger) len field, and remove the
> annoying restriction on calling show_ident multiple times in the same
> statement.)

When sparse does the hash table look up, if there is collision on the
hash table entry, sparse will compare the size first before the memcmp(=
).
That will reduce the number of the memcmp call it makes. I would like t=
o
keep the size of struct ident. If any thing, we can NUL terminate the s=
tring
in ident to make printing easy.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
