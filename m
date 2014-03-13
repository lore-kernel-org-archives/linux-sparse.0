From: m silverstri <michael.j.silverstri@gmail.com>
Subject: Re: How to run sparse tool?
Date: Thu, 13 Mar 2014 11:54:13 -0700
Message-ID: <CABMudhQt1B6kanw+u7A1yPnux-wUYGYq07qwFs4hGYhgdbYLTA@mail.gmail.com>
References: <CABMudhRd=YmZbPURf27cKiJKYLswZCGoMqoxvXqu3DeGT7k_7g@mail.gmail.com>
	<20140313180031.GA6144@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:51739 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbaCMSyN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Mar 2014 14:54:13 -0400
Received: by mail-ob0-f178.google.com with SMTP id wp18so1478534obc.23
        for <linux-sparse@vger.kernel.org>; Thu, 13 Mar 2014 11:54:13 -0700 (PDT)
In-Reply-To: <20140313180031.GA6144@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-sparse@vger.kernel.org

Thanks. 'make allmodconfig' works.
But before your answer, I am able to build and there is a .config
file. But why 'make C=2 drivers/staging/wlan-ng/' decide to build
config again ?



On Thu, Mar 13, 2014 at 11:00 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Michael.
>
> On Thu, Mar 13, 2014 at 09:49:48AM -0700, m silverstri wrote:
>> Hi,
>>
>> I read http://kernelnewbies.org/Sparse and try to run sparse tool.
>>
>> As a test, I run it on raspberry-pi/linux code base, by doing " make
>> C=2 drivers/staging/wlan-ng/", what I get is it asks me a list of
>> configuration question and it does not run sparse for me. How can I
>> bypass this setting up configuration and run sparse for the code?
>
> You cannot build the kernel source before the kernel is properly configured.
> You can use one of the shortcuts if you just want to build test this:
>
>     make allyesconfig
>
>        or
>
>    make allmodconfig
>
> This will configure your kernel and allow you to build the wlan-ng/
> drivers.
> And when you can build the drivers then you can also run sparse.
>
>         Sam
