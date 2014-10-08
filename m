From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Wed, 8 Oct 2014 18:26:23 +0800
Message-ID: <CANeU7Q==hANeGNEK3f-_LnNa-msVQgPa=mnk4k0qkuz5s=_K+w@mail.gmail.com>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
	<20141007094508.GN23154@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:45690 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbaJHK0Z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Oct 2014 06:26:25 -0400
Received: by mail-yh0-f53.google.com with SMTP id b6so3782962yha.40
        for <linux-sparse@vger.kernel.org>; Wed, 08 Oct 2014 03:26:24 -0700 (PDT)
In-Reply-To: <20141007094508.GN23154@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Thomas Graf <tgraf@suug.ch>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Oct 7, 2014 at 5:45 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> +     system ($check) == 0 or die;
>
> This just enables -Werror for everyone so now I can't run Sparse on
> itself now because there are old errors from 2007.
>
> lib.c:192:6: error: symbol 'error_die' redeclared with different type (originally declared at lib.h:97) - different modifiers
> lib.c:201:6: error: symbol 'die' redeclared with different type (originally declared at lib.h:93) - different modifiers

It depend on how you invoke sparse.
Do you invoke sparse by some thing like "make CC=./cgcc"?

>
> Btw, these errors also disable warnings for the rest of the file...  I
> don't think just because there are different modifiers it means that
> we should give up looking for other warnings.  In the kernel we miss
> some endian bugs because of this.

Are you suggesting change that type different error into warnings so
sparse can still check the rest of the file?

Chris
