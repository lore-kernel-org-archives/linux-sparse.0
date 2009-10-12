From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] New attribute designated_init: mark a struct as
 requiring designated init
Date: Sun, 11 Oct 2009 23:42:33 -0700
Message-ID: <20091012064233.GB6370@feather>
References: <20091010085732.GA10923@feather>
 <70318cbf0910100333m128e3500vb1659a55a9f49768@mail.gmail.com>
 <20091010160304.GA11876@feather>
 <70318cbf0910112218j50a63148t2e044bc5451dc0cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:34958 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZJLGqW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Oct 2009 02:46:22 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0910112218j50a63148t2e044bc5451dc0cb@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 11, 2009 at 10:18:24PM -0700, Christopher Li wrote:
> On Sat, Oct 10, 2009 at 9:03 AM, Josh Triplett <josh@joshtriplett.org=
> wrote:
> > After getting this patch reviewed, I intended to add many such
> > annotations myself. =A0I have patches sitting in my local Linux tre=
e.
> > (However, I don't plan to try to get the patches accepted into Linu=
x
> > until this attribute shows up in a Sparse release, since I don't wa=
nt to
> > make Linux require the latest Sparse from the git tree.)
>=20
> I apply your patch so you can have a fair chance to pitch to the
> kernel. If nobody use it, I can remove it later. I don't think you ne=
ed
> to wait for the patch to go into sparse release to collect feed back
> from lkml.

Oh, definitely.  I just don't think the patches should actually get
accepted into Linux before the next Sparse release.  I certainly plan t=
o
*submit* them. :)

Thanks for accepting the patch.

> > You *hope* that positional initialization will fail. :) =A0Some of =
these
> > types of structures contain many fields with the same or similar ty=
pes,
> > and initializers don't inherently contain a lot of distinguishing t=
ype
> > information that helps cause type errors rather than silent failure=
s.
>=20
> I am very interested to know some precedence from the kernel commit h=
istory.
> If we can find such a commit which changes the structure and breaks
> other initialization due to the position initialization, it will make=
 your
> case stronger as well.

I don't know of any cases in the commit history off the top of my head.
However, I do recall seeing this come up during LKML review comments on
patch, where the patch used positional initializers and the comments
suggested designated initializers.

> > Even if the positional initialization does fail, this failure will =
occur
> > at the time of attempting to change the structure, and many such
> > failures may occur all over the tree, making such changes significa=
ntly
> > more difficult. =A0With the designated_init attribute, sparse will =
warn
> > when attempting to create the structure initializer.
>=20
> Without sparse, you can temporary  insert some unused strange type
> into the beginning of the struct. That should cause any position init=
ializer
> fail to compile. You can then find call the call site.

Interesting idea!

However, again, this doesn't trigger the warning as soon as someone add=
s
a positional initializer; the person who wants to change the structure
will have to do this kind of work.  Warnings help ensure that those
types of changes get made by the person submitting potentially
problematic code, rather than the person who will trip over that code
later.  Warnings also reduce the load on patch reviewers, by making
certain types of issues less likely to make it to patch submission time=
,
and by letting reviewers suggest tools like sparse rather than having t=
o
point out each new issue.

> > With the designated_init attribute, someone making changes to a
> > structure can check that Sparse produces no warnings about position=
al
> > initializers and then know that certain types of changes can occur
> > without having to check every initializer. =A0For instance, removin=
g a
> > field will only require checking any initializer that initializes t=
hat
> > field, and the compiler will find all of those. =A0Adding a field t=
hat can
> > safely remain NULL does not require checking any initializers.
>=20
> I think the initializer is just a small part of the work if you even =
change
> the structure. You need to make sure the *code* use these C struct
> actually works as expected.

Very true.  However, the types of structs for which the designated_init
attribute will prove useful often already follow semantics that avoid
the need to check the code.  For instance, as long as you know that a
field can safely remain 0 except in code that wants to use it, you can
add a new field without checking every designated initializer.

> > (As an aside, though: any fundamental reason why we use that error-=
prone
> > approach rather than allocating one extra byte and NUL-terminating
> > idents? =A0Then we could drop the (larger) len field, and remove th=
e
> > annoying restriction on calling show_ident multiple times in the sa=
me
> > statement.)
>=20
> When sparse does the hash table look up, if there is collision on the
> hash table entry, sparse will compare the size first before the memcm=
p().
> That will reduce the number of the memcmp call it makes. I would like=
 to
> keep the size of struct ident. If any thing, we can NUL terminate the=
 string
> in ident to make printing easy.

=46air enough on the hash comparisons, though I do wonder how much valu=
e
we get from that compared to a highly optimized memcmp implementation;
if the strings differ in the first 4 or 8 bytes, I'd expect memcmp to
notice after one comparison.  But even if we keep the length, requiring
NUL termination seems highly useful.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
