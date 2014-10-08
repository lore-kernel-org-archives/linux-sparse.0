From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3] sparse: treat function pointers as pointers to const data
Date: Thu, 9 Oct 2014 02:00:02 +0800
Message-ID: <CANeU7QmR-HCp5--PhihSfM1Aan8bNGsPLgtewVVptjbfEZCj6A@mail.gmail.com>
References: <1410157803-3658-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAKv+Gu-jTrCnhuS0GEkifj1rA0gjh=cLLEXO9GLxNdw6ctn-Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:40313 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbaJHSAD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Oct 2014 14:00:03 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so1607913ykb.35
        for <linux-sparse@vger.kernel.org>; Wed, 08 Oct 2014 11:00:02 -0700 (PDT)
In-Reply-To: <CAKv+Gu-jTrCnhuS0GEkifj1rA0gjh=cLLEXO9GLxNdw6ctn-Ug@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Will Deacon <will.deacon@arm.com>

On Mon, Oct 6, 2014 at 10:44 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>> we only address the case where the function pointer is the target of
>> an assignment.

I apply the patch in my private branch but haven't push out yet.

I just want to confirm, you didn't find this kind of assignment in the
kernel, right?

Chris
