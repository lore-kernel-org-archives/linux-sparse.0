From: Christopher Li <sparse@chrisli.org>
Subject: Re: 'make install' target issues
Date: Tue, 27 Oct 2009 20:04:26 -0700
Message-ID: <70318cbf0910272004s2a5aba06r949a1f76445dfa8c@mail.gmail.com>
References: <449c10960910271737s4acf67dfsf29daf25fed9b53b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:33713 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbZJ1DEW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Oct 2009 23:04:22 -0400
Received: by iwn10 with SMTP id 10so309953iwn.4
        for <linux-sparse@vger.kernel.org>; Tue, 27 Oct 2009 20:04:26 -0700 (PDT)
In-Reply-To: <449c10960910271737s4acf67dfsf29daf25fed9b53b@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Oct 27, 2009 at 5:37 PM, Dan McGee <dan@archlinux.org> wrote:
> commit bb54f9a83eaa7c683e292a90fdfeebb54381c313
> Author: Christopher Li <sparse@chrisli.org>
> Date: =A0 Fri Dec 26 01:37:01 2008 -0800
> Subject: Clean up Makefile long lines
>
> Is there something I am missing? By default, the install program
> installs all files with rwxr-xr-x. I'd be happy to submit a patch to
> fix this.

That is a bug. Thanks for catching it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
