From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 07/10] Add support for multiarch system header files
Date: Mon, 6 Oct 2014 07:33:29 +0800
Message-ID: <CANeU7QnuZucjgq2b972ZxBi0e1TZpz=mMjo6SCRvk5mngXaETg@mail.gmail.com>
References: <53DFD350.6080701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:53658 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbaJEXdb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 5 Oct 2014 19:33:31 -0400
Received: by mail-wi0-f173.google.com with SMTP id fb4so3043427wid.12
        for <linux-sparse@vger.kernel.org>; Sun, 05 Oct 2014 16:33:29 -0700 (PDT)
In-Reply-To: <53DFD350.6080701@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Aug 5, 2014 at 2:39 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

May I have a more descriptive change log why is multiarch option useful?

> @@ -36,6 +36,9 @@ HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
>  GCC_BASE = $(shell $(CC) --print-file-name=)
>  BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
>
> +MULTIARCH_TRIPLET = $(shell $(CC) -print-multiarch 2>/dev/null)
> +BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"

My gcc(4.8, FC20) does not support "-print-multiarch".
So the patch need to handle that case.
As far as I can tell, this patch is not ready for empty  MULTIARCH_TRIPLET.

> +       if (multiarch_dir && *multiarch_dir) {
> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
> +       }

Not sure empty multiarch_dir works here.

Chris
