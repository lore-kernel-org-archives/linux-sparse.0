From: Christopher Li <sparse@chrisli.org>
Subject: Re: Possible bug with _Static_assert & sparse
Date: Wed, 30 Jul 2014 11:40:37 -0700
Message-ID: <CANeU7QnAH-ctgLL-4k1LdMy6SN4hG0nvtsLCzUaQ=NVv8GZajA@mail.gmail.com>
References: <CADz3at1Hz5oiWT2MZvK2zOrtu7=1QYvny8RNE+QnoTOSJWHqWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:52577 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbaG3Ski (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Jul 2014 14:40:38 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so2375526qgd.27
        for <linux-sparse@vger.kernel.org>; Wed, 30 Jul 2014 11:40:37 -0700 (PDT)
In-Reply-To: <CADz3at1Hz5oiWT2MZvK2zOrtu7=1QYvny8RNE+QnoTOSJWHqWQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Holmes <mike.holmes@linaro.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 30, 2014 at 10:32 AM, Mike Holmes <mike.holmes@linaro.org> wrote:
> Hi
>
> I wondered if the following sparse error indication was expected
> behaviour or if it is a bug,
> I would not expect sparse to error with "got 9"
>
>
> $ cat static.c
> #include <stdio.h>
>
> #define fake 9
> _Static_assert( fake > 8, "test message");

_Static_assert is a C11 thing?
The current sparse know nothing about _Static_assert().
So it treat it as a function declare.

Patch are welcome if any one want to give it a try.

Chris
