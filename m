From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each
 BB
Date: Tue, 09 Oct 2012 20:12:27 -0400
Message-ID: <5074BD6B.2090501@pobox.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59046 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab2JJAMb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 20:12:31 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so4507277qch.19
        for <linux-sparse@vger.kernel.org>; Tue, 09 Oct 2012 17:12:30 -0700 (PDT)
In-Reply-To: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 10/09/2012 07:34 PM, Jonathan Neusch=C3=A4fer wrote:
> This is required for producing valid LLVM bitcode.
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>   sparse-llvm.c              |   17 ++++++++++++++++-
>   validation/backend/loop2.c |   13 +++++++++++++
>   2 files changed, 29 insertions(+), 1 deletion(-)
>   create mode 100644 validation/backend/loop2.c

Looks sane... but I did not verify whether or not this reordering is sa=
fe



--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
