From: Tomas Klacko <tomas.klacko@gmail.com>
Subject: including sparse headers in C++ code
Date: Sat, 9 Oct 2010 18:40:26 +0200
Message-ID: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48825 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595Ab0JIQk1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Oct 2010 12:40:27 -0400
Received: by iwn6 with SMTP id 6so1573069iwn.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Oct 2010 09:40:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I am including sparse headers in a C++ code,
but this does not work because of the use of keywords
like new and namespace, (and retyping).

What is your stance on this?
I mean, would you accept a patch or is there
some other way which I have missed?

Thanks,
Tomas Klacko
