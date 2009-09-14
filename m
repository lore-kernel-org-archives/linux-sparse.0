From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Mon, 14 Sep 2009 21:44:37 +0200
Message-ID: <200909142144.37273.kdudka@redhat.com>
References: <200908282330.08332.kdudka@redhat.com> <200909141932.12684.kdudka@redhat.com> <70318cbf0909141055m218d2819m592f9fa72cc26774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756893AbZINTom (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 15:44:42 -0400
In-Reply-To: <70318cbf0909141055m218d2819m592f9fa72cc26774@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Monday 14 of September 2009 19:55:49 Christopher Li wrote:
> On Mon, Sep 14, 2009 at 10:32 AM, Kamil Dudka <kdudka@redhat.com> wrote:
> > As for the long term solution, I don't think it's possible without
> > breaking the current API/ABI. What about using a bitfield instead? I can
> > see it solved this way in <gcc/tree.h>.
>
> I am actually not afraid of breaking current API/ABI because there is not
> enough sparse user application to worry about. Just recompile the apps
> should be fine. Please warn me if any one disagree.
>
> As for long term, here is my plan, it will go will with Al's replace same
> type with same type pointer plan as well.
>
> We need to have a different structure to support the extended attributes
> for ctype. Current "contexts" and "as" should go into that extended
> attribute as well. Then ctype should have one pointer for extended
> attributes. For most common case, the extended attribute pointer is just
> NULL.
>
> Because the extended attribute pointer is possibles to be shared between
> different ctypes. It is not allow to modify the extended attribute struct
> from ctype directly. Instead it should replace with a new one.
> We can even hash the extended attribute struct so same attribute struct
> will have the same pointer, just like ident. That will make comparing
> attribute is the same much easier.
>
> I try it before, it is  hard to do because current code does implicit
> assign for the ctype.

It sounds like a tough challenge to me :-)

I am playing with the SPARSE API now. Any chance to pass in a unique ID
to each symbol? (as equivalent to DECL_UID from <gcc/tree.h>) I can of course 
manage an ptr/ID mapping at application level. I am only curious if this is 
possible to place directly into SPARSE, so that other apps could gain
from it. Please let me know if such functionality is already implemented
in SPARSE.

Kamil
