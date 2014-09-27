From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/10] don't run sparse{c,i} tests when sparse-llvm is disabled
Date: Sat, 27 Sep 2014 12:29:44 +0800
Message-ID: <CANeU7QkFPTW04ECjrJKHO51g38R6r3Rt8jX74PsAnEgpxRqxYw@mail.gmail.com>
References: <53DFD320.2050903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:65066 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaI0E3q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 00:29:46 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so7435577wgg.19
        for <linux-sparse@vger.kernel.org>; Fri, 26 Sep 2014 21:29:44 -0700 (PDT)
In-Reply-To: <53DFD320.2050903@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Aug 5, 2014 at 2:38 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> +if [ ! -x "$default_path/sparse-llvm" ]; then
> +       disabled_cmds="sparsec sparsei sparse-llvm"
> +fi

I think this can  be simplified as if the test command was not found,
then that test will be disabled. It doesn't need to be sparse llvm, it
can be other
test program.

We don't need to set an disable_cmds list then check against that list.

Chris
