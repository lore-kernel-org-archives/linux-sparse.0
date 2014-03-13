From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: How to run sparse tool?
Date: Thu, 13 Mar 2014 19:00:31 +0100
Message-ID: <20140313180031.GA6144@ravnborg.org>
References: <CABMudhRd=YmZbPURf27cKiJKYLswZCGoMqoxvXqu3DeGT7k_7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:56985 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbaCMSAz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Mar 2014 14:00:55 -0400
Content-Disposition: inline
In-Reply-To: <CABMudhRd=YmZbPURf27cKiJKYLswZCGoMqoxvXqu3DeGT7k_7g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: m silverstri <michael.j.silverstri@gmail.com>
Cc: linux-sparse@vger.kernel.org

Hi Michael.

On Thu, Mar 13, 2014 at 09:49:48AM -0700, m silverstri wrote:
> Hi,
> 
> I read http://kernelnewbies.org/Sparse and try to run sparse tool.
> 
> As a test, I run it on raspberry-pi/linux code base, by doing " make
> C=2 drivers/staging/wlan-ng/", what I get is it asks me a list of
> configuration question and it does not run sparse for me. How can I
> bypass this setting up configuration and run sparse for the code?

You cannot build the kernel source before the kernel is properly configured.
You can use one of the shortcuts if you just want to build test this:

    make allyesconfig

       or

   make allmodconfig

This will configure your kernel and allow you to build the wlan-ng/
drivers.
And when you can build the drivers then you can also run sparse.

	Sam
