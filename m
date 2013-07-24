From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add __builtin_va_arg_pack() and __builtin_va_arg_pack_len()
Date: Wed, 24 Jul 2013 09:41:02 -0700
Message-ID: <CANeU7Qn5pj76zecWoLuSU+c85Va-wU9e4hkLxB-GsvRM-1AV1g@mail.gmail.com>
References: <CANeU7Qn5LFSKN9+vX+yGVovbcWNMmJT4HU6Se4ObsoJHh851fA@mail.gmail.com>
	<1374230020-26826-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47739 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab3GXQlE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Jul 2013 12:41:04 -0400
Received: by mail-ob0-f172.google.com with SMTP id f8so1416982obp.3
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jul 2013 09:41:02 -0700 (PDT)
In-Reply-To: <1374230020-26826-1-git-send-email-jlayton@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-sparse@vger.kernel.org, penberg@kernel.org

On Fri, Jul 19, 2013 at 3:33 AM, Jeff Layton <jlayton@redhat.com> wrote:
> this patch stops sparse from complaining about them not being defined:
>
>     /usr/include/bits/stdio2.h:98:25: error: undefined identifier '__builtin_va_arg_pack'
>     /usr/include/bits/stdio2.h:98:25: error: not a function <noident>
>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Looks good, will apply.

Chris
