From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 21:43:51 -0500
Message-ID: <118833cc0703061843s22d35a9ei17fd48f97fc7626a@mail.gmail.com>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	 <20070306023351.GB31138@chrisli.org>
	 <20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	 <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	 <20070305224025.fe867c28.rdunlap@xenotime.net>
	 <1173205177.32333.34.camel@dv>
	 <20070306125846.0e3a684a.rdunlap@xenotime.net>
	 <70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
	 <20070306151252.239c58f8.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:7047 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030389AbXCGCnw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 21:43:52 -0500
Received: by wr-out-0506.google.com with SMTP id 58so26060wri
        for <linux-sparse@vger.kernel.org>; Tue, 06 Mar 2007 18:43:52 -0800 (PST)
In-Reply-To: <20070306151252.239c58f8.rdunlap@xenotime.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Christopher Li <sparse@chrisli.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

Try running sparse under valgrind to see if there is some memory
corruption at an
earlier stage.

Morten
