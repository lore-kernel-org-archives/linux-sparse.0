From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 16:00:21 -0500
Message-ID: <118833cc0811111300q4e7571f5o2a56a652f9a941e9@mail.gmail.com>
References: <20081111135816.GA25986@logfs.org>
	 <1226412106.4478.5.camel@johannes.berg>
	 <20081111141459.GB25986@logfs.org>
	 <20081111201328.GA10073@artemis.corp>
	 <20081111202849.GD25986@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:26764 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbYKKVA0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 16:00:26 -0500
Received: by fg-out-1718.google.com with SMTP id 19so137150fgg.17
        for <linux-sparse@vger.kernel.org>; Tue, 11 Nov 2008 13:00:21 -0800 (PST)
In-Reply-To: <20081111202849.GD25986@logfs.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@logfs.org>
Cc: Pierre Habouzit <madcoder@debian.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, 505177@bugs.debian.org

The problem is not the header files, but that we need to ensure that the
proper include path is set up.

This is needed because sparse currently tries to mimic some
indeterminate gcc version in terms of predefines.  A similar solution
would be needed to mimic any other compiler.  We obviously need
a default path for system headers somehow.

In this case, we could probably get away with accepting a definition
of GCC_INTERNAL_INCLUDE on the command line and use that in
preference over whatever is in pre-process.h

Morten
