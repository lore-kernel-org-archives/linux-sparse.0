From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Ignore the may_alias GCC attribute
Date: Tue, 1 Jun 2010 15:31:44 -0700
Message-ID: <AANLkTim4BaJ2JGBU1vUi-GguEZAdZY70Oo070J0hfHoq@mail.gmail.com>
References: <AANLkTikvGsi4Ju25yduhlszVP3BOiCEEHrlO6hNoGKFV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59185 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab0FAWbp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jun 2010 18:31:45 -0400
Received: by gye5 with SMTP id 5so1623401gye.19
        for <linux-sparse@vger.kernel.org>; Tue, 01 Jun 2010 15:31:44 -0700 (PDT)
In-Reply-To: <AANLkTikvGsi4Ju25yduhlszVP3BOiCEEHrlO6hNoGKFV@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Jun 1, 2010 at 9:35 AM, Damien Lespiau <damien.lespiau@gmail.com> wrote:
> Unfortunately, linux-sparse seems to reject my git send-emails with
> GMail's SMTP server, so I'm attaching the git format-patch instead.
>
> may_alias is used in the wild (glib) and makes sparse spew a lot of
> unhelpful warning messages. Ignore it (for now?).
>

The patch looks good. Will apply.

Chris
