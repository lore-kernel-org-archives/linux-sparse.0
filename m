From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: How to run sparse tool?
Date: Thu, 13 Mar 2014 22:23:49 +0100
Message-ID: <20140313212349.GA6326@ravnborg.org>
References: <CABMudhRd=YmZbPURf27cKiJKYLswZCGoMqoxvXqu3DeGT7k_7g@mail.gmail.com>
 <20140313180031.GA6144@ravnborg.org>
 <CABMudhQt1B6kanw+u7A1yPnux-wUYGYq07qwFs4hGYhgdbYLTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:59181 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbaCMVYF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Mar 2014 17:24:05 -0400
Content-Disposition: inline
In-Reply-To: <CABMudhQt1B6kanw+u7A1yPnux-wUYGYq07qwFs4hGYhgdbYLTA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: m silverstri <michael.j.silverstri@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 13, 2014 at 11:54:13AM -0700, m silverstri wrote:
> Thanks. 'make allmodconfig' works.
> But before your answer, I am able to build and there is a .config
> file. But why 'make C=2 drivers/staging/wlan-ng/' decide to build
> config again ?
No idea.
Maybe "make V=1" or "make V=2" can give a hint.
Something triggers the re-run of the config which is usual because soem Kconfig files are touched, or .config.

	Sam
