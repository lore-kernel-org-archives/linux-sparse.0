From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 10 Oct 2012 09:31:31 +0300
Message-ID: <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<5074BD6B.2090501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50423 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab2JJGbc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Oct 2012 02:31:32 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so230418wib.1
        for <linux-sparse@vger.kernel.org>; Tue, 09 Oct 2012 23:31:31 -0700 (PDT)
In-Reply-To: <5074BD6B.2090501@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Oct 10, 2012 at 3:12 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 10/09/2012 07:34 PM, Jonathan Neusch=E4fer wrote:
>>
>> This is required for producing valid LLVM bitcode.
>>
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Christopher Li <sparse@chrisli.org>
>> Cc: Jeff Garzik <jgarzik@redhat.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
>> ---
>>   sparse-llvm.c              |   17 ++++++++++++++++-
>>   validation/backend/loop2.c |   13 +++++++++++++
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>   create mode 100644 validation/backend/loop2.c
>
> Looks sane... but I did not verify whether or not this reordering is =
safe

Ditto. Jonathan, care to explain why you think it is safe? I still
don't know Sparse's linearized IR well enough to convince myself this
is OK.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
