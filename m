From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/2] sparse, llvm: Fix type of loaded values
Date: Wed, 10 Oct 2012 09:34:21 +0300
Message-ID: <CAOJsxLGQSGXptwNU36XNvLHNmb1EAYngxavRvvRnQyF95A_=YQ@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<1349825676-1713-2-git-send-email-j.neuschaefer@gmx.net>
	<5074BD9E.9030002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49900 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab2JJGeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Oct 2012 02:34:23 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so104003wey.19
        for <linux-sparse@vger.kernel.org>; Tue, 09 Oct 2012 23:34:22 -0700 (PDT)
In-Reply-To: <5074BD9E.9030002@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Oct 10, 2012 at 3:13 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 10/09/2012 07:34 PM, Jonathan Neusch=E4fer wrote:
>>
>> Instead of making the computed address a pointer to an int type
>> large enough to hold a pointer, make it a pointer to the memory
>> object being loaded.  This fixes another LLVM warning.
>>
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Christopher Li <sparse@chrisli.org>
>> Cc: Jeff Garzik <jgarzik@redhat.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
>> ---
>>   sparse-llvm.c                  |    2 +-
>>   validation/backend/load-type.c |   12 ++++++++++++
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>   create mode 100644 validation/backend/load-type.c
>
> Acked-by: Jeff Garzik <jgarzik@redhat.com>

Applied, thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
