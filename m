From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse, llvm: Don't fail the build if LLVM is too old
Date: Fri, 25 Nov 2011 11:50:14 -0800
Message-ID: <CANeU7Qkac78FrYJ4daC=Kq+gFnw67ih-Ho-RZe79P=8JoTqiYw@mail.gmail.com>
References: <1322204804-6627-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44392 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab1KYTuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 14:50:16 -0500
Received: by faas1 with SMTP id s1so2361270faa.19
        for <linux-sparse@vger.kernel.org>; Fri, 25 Nov 2011 11:50:15 -0800 (PST)
In-Reply-To: <1322204804-6627-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

=46irst of all, I want to make the sparse-llvm works on release version=
 as well,
if that is not too much trouble.


On Thu, Nov 24, 2011 at 11:06 PM, Pekka Enberg <penberg@kernel.org> wro=
te:
> =A0HAVE_LLVM:=3D$(shell llvm-config --version >/dev/null 2>&1 && echo=
 'yes')
> +HAVE_LLVM_VERSION:=3D$(shell llvm-config --version | grep "^[3-9].*"=
 >/dev/null 2>&1 && echo yes)
> +LLVM_VERSION=3D$(shell llvm-config --version)
>
>  GCC_BASE =3D $(shell $(CC) --print-file-name=3D)
>  BASIC_CFLAGS =3D -DGCC_BASE=3D\"$(GCC_BASE)\"
> @@ -65,7 +67,13 @@ else
>  $(warning Your system does not have libgtk2, disabling test-inspect)
>  endif
>
> -ifeq ($(HAVE_LLVM),yes)
> +ifneq ($(HAVE_LLVM),yes)
> +$(warning Your system does not have llvm, disabling sparse-llvm)

Notice you use recursive assign here. It will cause "shell llvm-config
--version"
being execute every time $(LLVM_VERSION) is expanded. That slow down
the makefile. Because LLVM_VERSION don't change during the compile.
Better make it non-recursive assign so the llvm-config only evaluate on=
ce.

I also don't want to put the sparse-llvm rules section in nested if.
That is  makes it harder to read.

I am thinking some thing like this:

LLVM_VERSION :=3D $(shell llvm-config --version 2>/dev/null)
LLVM_VERSION_LIST :=3D $(subst ., ,$(LLVM_VERSION))
LLVM_VERSION_MAJOR :=3D $(word 1, $(LLVM_VERSION_LIST))
HAVE_LLVM_V3 :=3D $(shell [ "$(LLVM_VERSION_MAJOR)" -ge 3 ] > /dev/null
2>&1 && echo yes)

ifeq ($(HAVE_LLVM_V3),yes)

# rules to compile sparse-llvm

else

# warning of LLVM don't exist or too old

endif


Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
