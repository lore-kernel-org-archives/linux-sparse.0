From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Sat, 24 Mar 2007 07:44:56 +0100
Message-ID: <20070324064456.GA13745@uranus.ravnborg.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com> <20070322221050.GC22151@chrisli.org> <20070323150459.52b02342.rdunlap@xenotime.net> <20070323233127.GA10115@uranus.ravnborg.org> <20070323164307.3e2e2803.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:50091 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbXCXGog (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 24 Mar 2007 02:44:36 -0400
Content-Disposition: inline
In-Reply-To: <20070323164307.3e2e2803.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Christopher Li <sparse@chrisli.org>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

> 
> > You could argue that the error from sparse could be better but
> > it is preferable to have consistent style over the kernel.
> 
> I lean more towards "is it valid C or not"?
I thought all the attribute() stuff was purely gcc extensions.

	Sam
