From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] sparse: treat function pointers as pointers to const data
Date: Wed, 15 Oct 2014 09:10:04 +0200
Message-ID: <CAKv+Gu-zDfhhnDxQ0PeW_k85-xZkF8UJbuEHda5NPNWBsdRgrw@mail.gmail.com>
References: <1410157803-3658-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAKv+Gu-jTrCnhuS0GEkifj1rA0gjh=cLLEXO9GLxNdw6ctn-Ug@mail.gmail.com>
	<CANeU7QmR-HCp5--PhihSfM1Aan8bNGsPLgtewVVptjbfEZCj6A@mail.gmail.com>
	<CAKv+Gu92fB1oHxn4jDCvNYZ4jhWpbtS-ANhX7LUx73w-+je-0Q@mail.gmail.com>
	<CAKv+Gu_7tgBVJ9uLRDazhMoj88xu5JS89VkW2UumFxKq65ze7g@mail.gmail.com>
	<CANeU7Qm=AudXFYxNDyrachGRoAurKTzixQ5dcLdrJPcTr7GS+g@mail.gmail.com>
	<CAKv+Gu_N=BO8K4nEpJo8=Z5fSfmD+6bEGQCDdR6QVVUGUE2VeQ@mail.gmail.com>
	<CANeU7QnWYBXZ7eX5cm6d_Xsj-OJTsJNtkC4PDLkxc26Cbe2kqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:42472 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaJOHKG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Oct 2014 03:10:06 -0400
Received: by mail-la0-f42.google.com with SMTP id gf13so567088lab.15
        for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2014 00:10:05 -0700 (PDT)
In-Reply-To: <CANeU7QnWYBXZ7eX5cm6d_Xsj-OJTsJNtkC4PDLkxc26Cbe2kqg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Will Deacon <will.deacon@arm.com>

On 15 October 2014 09:06, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Oct 15, 2014 at 1:16 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> Which upstream repo is that? I couldn't find it on
>> git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>
> https://git.kernel.org/cgit/devel/sparse/chrisl/sparse.git/
>

OK, thanks!
