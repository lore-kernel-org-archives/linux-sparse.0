From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] New attribute designated_init: mark a struct as requiring
	designated init
Date: Sat, 10 Oct 2009 03:33:20 -0700
Message-ID: <70318cbf0910100333m128e3500vb1659a55a9f49768@mail.gmail.com>
References: <20091010085732.GA10923@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f203.google.com ([209.85.212.203]:36000 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZJJKd4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Oct 2009 06:33:56 -0400
In-Reply-To: <20091010085732.GA10923@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 10, 2009 at 1:58 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> Some structure types provide a set of fields of which most users will
> only initialize the subset they care about. =A0Users of these types s=
hould
> always use designated initializers, to avoid relying on the specific
> structure layout. =A0Examples of this type of structure include the m=
any

The patch is very well written with nice documentations and test case.
It applies and runs fine.

I am curious weather this is some thing the kernel developers want to
use. Please speak up if you want to annotate the kernel structure to
issue such warning. If some one use it, I have no problem adding it to
sparse.

I am not sure how useful this is yet.  If the structure is changed, mos=
t
likely the positional initialization will fail due to type mismatching.
Some real life example how this feature can expose some otherwise
hard to detect bug would be nice.

With this approach, we need to annotate the kernel to benefit from it.
Another idea is that we can find out how different part of the kernel
initialize the same structure. If most of them using designated init th=
en
the few non-conforming can get a warning. This approach is more
complicate.  But it does not need to change the kernel.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning=
(e->pos, "%s%s%spositional init of field in %s %s, declared with attrib=
ute designated_init",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ctype->ident ? "in initializer for " : "",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ctype->ident ? ctype->ident->name : "",

ident->name has no guarantee of terminating by NUL.
You want to use "%.*s" with ident->size, ident->name here.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
