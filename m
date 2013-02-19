From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add built-in byte swap identifiers
Date: Tue, 19 Feb 2013 11:13:09 -0800
Message-ID: <CANeU7QmfNK8tT2R3vKN95A7YSnJZvbVo+UkAd87sx8S2hX5jog@mail.gmail.com>
References: <20130218183629.d2a9238ac848758359582e28@freescale.com>
	<CANeU7Q=W8zZEngeweCGDkEpPGJMrADFgnibQVUFvGBwsppVq=A@mail.gmail.com>
	<20130219114103.4630a9053ef81cd4e0e1a7b8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:54509 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934043Ab3BSTNK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Feb 2013 14:13:10 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so6918575obb.28
        for <linux-sparse@vger.kernel.org>; Tue, 19 Feb 2013 11:13:09 -0800 (PST)
In-Reply-To: <20130219114103.4630a9053ef81cd4e0e1a7b8@freescale.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Feb 19, 2013 at 9:41 AM, Kim Phillips
<kim.phillips@freescale.com> wrote:
> this patch stops sparse from complaining about them not being
> defined:

> v2: add a test for builtin_bswap{16,32,64}

Looks good to me. I will apply that.

Thanks

Chris
