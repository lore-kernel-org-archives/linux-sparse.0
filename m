From: Alecs King <alecsk@gmail.com>
Subject: pre-process.c:569:18: error: bad constant expression
Date: Sat, 31 Dec 2005 15:30:06 +0800
Message-ID: <20051231073006.GA3583@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:18616 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751314AbVLaHXi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 02:23:38 -0500
Received: by zproxy.gmail.com with SMTP id 40so2029425nzk
        for <linux-sparse@vger.kernel.org>; Fri, 30 Dec 2005 23:23:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>

        int nargs = sym->arglist ? sym->arglist->count.normal : 0;
        struct arg args[nargs];

gcc went fine but sparse complaint about this.  Declaring such kind of
variable-sized arrays is allowed or not?  Seems 'nargs' cannot be
evaluated until runtime..?

-- 
Alecs King
