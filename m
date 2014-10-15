From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Wed, 15 Oct 2014 22:23:40 +0800
Message-ID: <CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>
References: <54398BA5.6050005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:42831 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaJOOXl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Oct 2014 10:23:41 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so958142qgd.15
        for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2014 07:23:41 -0700 (PDT)
In-Reply-To: <54398BA5.6050005@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Oct 12, 2014 at 3:57 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
>
> -       system ($check) == 0 or die;
> +       system ($check) == 0 or exit 1;

Why not exit with the error code from sparse here?
Sparse might exit with other error code than "1" in the future.

Chris
