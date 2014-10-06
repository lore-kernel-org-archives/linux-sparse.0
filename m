From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 07/10] Add support for multiarch system header files
Date: Mon, 06 Oct 2014 11:31:39 +0100
Message-ID: <54326F8B.1050201@ramsay1.demon.co.uk>
References: <53DFD350.6080701@ramsay1.demon.co.uk> <CANeU7QnuZucjgq2b972ZxBi0e1TZpz=mMjo6SCRvk5mngXaETg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:55940 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751397AbaJFKbt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Oct 2014 06:31:49 -0400
In-Reply-To: <CANeU7QnuZucjgq2b972ZxBi0e1TZpz=mMjo6SCRvk5mngXaETg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 06/10/14 00:33, Christopher Li wrote:
> On Tue, Aug 5, 2014 at 2:39 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> May I have a more descriptive change log why is multiarch option useful?
> 
>> @@ -36,6 +36,9 @@ HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
>>  GCC_BASE = $(shell $(CC) --print-file-name=)
>>  BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
>>
>> +MULTIARCH_TRIPLET = $(shell $(CC) -print-multiarch 2>/dev/null)
>> +BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
> 
> My gcc(4.8, FC20) does not support "-print-multiarch".

Yep, same is true for cygwin.

> So the patch need to handle that case.
> As far as I can tell, this patch is not ready for empty  MULTIARCH_TRIPLET.

Hmm, works for me! Could you describe the failure you are seeing.

> 
>> +       if (multiarch_dir && *multiarch_dir) {
>> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
>> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
>> +       }
> 
> Not sure empty multiarch_dir works here.

Again, it works for me. :-D

ATB,
Ramsay Jones



