From: Diego Pinheiro <diegoquintanap@gmail.com>
Subject: Flow graph - identify loop body
Date: Fri, 13 May 2011 12:32:40 -0400
Message-ID: <BANLkTikHXzguWK00TCO41x1_13BffCYyRg@mail.gmail.com>
References: <BANLkTikjg-6QD3_7H533fUKQm39aAj-xyA@mail.gmail.com>
	<BANLkTimmJJYcmpLE7MevAk-18GxmQpGftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45610 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759198Ab1EMQcl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 May 2011 12:32:41 -0400
Received: by gwaa18 with SMTP id a18so937909gwa.19
        for <linux-sparse@vger.kernel.org>; Fri, 13 May 2011 09:32:41 -0700 (PDT)
In-Reply-To: <BANLkTimmJJYcmpLE7MevAk-18GxmQpGftw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello,

I'm trying to identify loop bodies to write its information in a xml
file, but i didn't get how sparse works with it.

How could I know which node is a loop body in the flow graph?
