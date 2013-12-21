From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Define __CHAR_BIT__
Date: Sat, 21 Dec 2013 09:20:15 -0800
Message-ID: <CANeU7QnwK86w5TjboqjDm4xAPf0P9rw6bnp3jDWrF8j3C2vqQg@mail.gmail.com>
References: <1387431987-29219-1-git-send-email-cota@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44594 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab3LURUQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 21 Dec 2013 12:20:16 -0500
Received: by mail-ob0-f182.google.com with SMTP id wp4so3999928obc.41
        for <linux-sparse@vger.kernel.org>; Sat, 21 Dec 2013 09:20:15 -0800 (PST)
In-Reply-To: <1387431987-29219-1-git-send-email-cota@braap.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Emilio G. Cota" <cota@braap.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Dec 18, 2013 at 9:46 PM, Emilio G. Cota <cota@braap.org> wrote:
> From: "Emilio G. Cota" <cota@braap.org>
>
> gcc defines __CHAR_BIT__ as a pre-defined macro.
>
> Define __CHAR_BIT__ in sparse so that code that needs it (e.g. code
> using CHAR_BIT from limits.h) does not generate false warnings.

Please provide a test case with this change. The change looks good
otherwise.

Chris
