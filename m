From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Mon, 14 Sep 2009 10:55:49 -0700
Message-ID: <70318cbf0909141055m218d2819m592f9fa72cc26774@mail.gmail.com>
References: <200908282330.08332.kdudka@redhat.com>
	 <70318cbf0908281444q735b7b9fm73f0fcbdbaeefa7b@mail.gmail.com>
	 <70318cbf0909141027y69ddecc2y591ffb6aca300fca@mail.gmail.com>
	 <200909141932.12684.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:53122 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024AbZINRzp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 13:55:45 -0400
Received: by vws33 with SMTP id 33so546948vws.33
        for <linux-sparse@vger.kernel.org>; Mon, 14 Sep 2009 10:55:49 -0700 (PDT)
In-Reply-To: <200909141932.12684.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Sep 14, 2009 at 10:32 AM, Kamil Dudka <kdudka@redhat.com> wrote:
> As for the long term solution, I don't think it's possible without breaking
> the current API/ABI. What about using a bitfield instead? I can see it solved
> this way in <gcc/tree.h>.

I am actually not afraid of breaking current API/ABI because there is not
enough sparse user application to worry about. Just recompile the apps should
be fine. Please warn me if any one disagree.

As for long term, here is my plan, it will go will with Al's replace same
type with same type pointer plan as well.

We need to have a different structure to support the extended attributes
for ctype. Current "contexts" and "as" should go into that extended attribute
as well. Then ctype should have one pointer for extended attributes.
For most common case, the extended attribute pointer is just NULL.

Because the extended attribute pointer is possibles to be shared between
different ctypes. It is not allow to modify the extended attribute struct
from ctype directly. Instead it should replace with a new one.
We can even hash the extended attribute struct so same attribute struct
will have the same pointer, just like ident. That will make comparing attribute
is the same much easier.

I try it before, it is  hard to do because current code does implicit
assign for the ctype.

Chris
