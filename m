From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] Sparse/LLVM updates
Date: Thu, 11 Oct 2012 19:34:04 -0700
Message-ID: <CANeU7Q=O_2UGjo0eUF=r4tqPFey0wpX3ww_g+6SiB_PeejAF-g@mail.gmail.com>
References: <CAOJsxLHYpiNPo7DUMrbfJGkw1ivB440ZMMAaYOmJT9uyTAbzTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:57784 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab2JLCeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Oct 2012 22:34:05 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1698094lag.19
        for <linux-sparse@vger.kernel.org>; Thu, 11 Oct 2012 19:34:04 -0700 (PDT)
In-Reply-To: <CAOJsxLHYpiNPo7DUMrbfJGkw1ivB440ZMMAaYOmJT9uyTAbzTw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

The change looks good.

It is pull and updated on the github sparse repository.

Thanks

Chris

On Tue, Oct 9, 2012 at 11:35 PM, Pekka Enberg <penberg@kernel.org> wrot=
e:
> Hi Chris,
>
> On Tue, Oct 9, 2012 at 9:34 AM, Pekka Enberg <penberg@kernel.org> wro=
te:
>> Hi Chris,
>>
>> Please pull the latest Sparse/LLVM tree from:
>>
>>   git@github.com:penberg/sparse-llvm.git llvm/core
>>
>> It contains few LLVM backend fixes from myself and Jonathan Neusch=E4=
fer.
>>
>>                         Pekka
>>
>> ------------------>
>
> I have added one more LLVM backend fix from Jonathan to the branch:
>
> The following changes since commit 063236fd3f46bc83b49172f5ecb597e0a9=
1cede8:
>
>   ptrlist.c: fix a typo in a comment (2012-06-26 00:54:24 -0700)
>
> are available in the git repository at:
>   git@github.com:penberg/sparse-llvm.git llvm/core
>
> Jonathan Neusch=E4fer (3):
>       sparse, llvm: 'Verify' the LLVM module before writing it
>       sparse, llvm: convert the condition of branch/select to bool
>       sparse, llvm: Fix type of loaded values
>
> Pekka Enberg (2):
>       sparse, llvm: Fix SIGSEGV for extern symbols
>       sparse, llvm: Fix 'void' return type code generation
>
>  sparse-llvm.c                         |   38 +++++++++++++++++++++++=
+++++----
>  validation/backend/extern.c           |   11 +++++++++
>  validation/backend/int-cond.c         |   30 +++++++++++++++++++++++=
+++
>  validation/backend/load-type.c        |   12 ++++++++++
>  validation/backend/void-return-type.c |   13 +++++++++++
>  5 files changed, 99 insertions(+), 5 deletions(-)
>  create mode 100644 validation/backend/extern.c
>  create mode 100644 validation/backend/int-cond.c
>  create mode 100644 validation/backend/load-type.c
>  create mode 100644 validation/backend/void-return-type.c
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
