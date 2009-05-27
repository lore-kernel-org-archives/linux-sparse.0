From: Anderson Lizardo <anderson.lizardo@gmail.com>
Subject: pysparse: Python bindings for sparse
Date: Tue, 26 May 2009 21:38:25 -0400
Message-ID: <5b5833aa0905261838r6ddfb0f4xa343f787c47e4f40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:62161 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbZE0BiY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 May 2009 21:38:24 -0400
Received: by ewy24 with SMTP id 24so4193978ewy.37
        for <linux-sparse@vger.kernel.org>; Tue, 26 May 2009 18:38:25 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I am proud to announce the availability of pysparse, that consists of
Python bindings for sparse. It can be obtained from:

http://gitorious.org/pysparse/pysparse

Please note it is the initial commit, and many things are missing (see
the TODO section on the README). But I've already added enough support
to port test-dissect, test-lexing and test-linearize to python, and
they work just fine :)

My plans are to add support for more functions incrementally as I
become more familiar with the current public sparse API.

Comments, suggestions and contributions are welcome. Note that I've
intentionally licensed pysparse under the MIT license so that it can
be added to a future sparse release licensed under it (if the sparse
maintainers want so). But for now pysparse can live outside sparse
tree just fine.

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
