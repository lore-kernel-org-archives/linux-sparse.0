From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] add support for LLP64 arch
Date: Thu, 9 Feb 2017 06:33:46 +0800
Message-ID: <CANeU7QkYvDA27AbJaj9i+qMOLhnGW+YAKtEQCzOEguK6kOWvdg@mail.gmail.com>
References: <CANeU7QkYmA1opeNQTYjOUXs8hSn1oG3RumVtR094rb4w8KucEQ@mail.gmail.com>
 <20170208221549.17543-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35866 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdBHXCG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 18:02:06 -0500
Received: by mail-it0-f65.google.com with SMTP id f200so607645itf.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 15:02:05 -0800 (PST)
In-Reply-To: <20170208221549.17543-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Feb 9, 2017 at 6:15 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> There was recently on the mailing list some questions
> and a need to support LLP64 model.
>
> This patch add is by adjusting a few size-related variables
> under the control of a new flag: -msize-llp64 (ugly name
> but we already have we have '-msize-long').

That looks much better. Applied on sparse-next.

Thanks

Chris
