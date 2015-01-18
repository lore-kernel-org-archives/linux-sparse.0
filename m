From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: sparse error: got __int128
Date: Sun, 18 Jan 2015 07:29:59 -0500
Message-ID: <54BBA747.1040204@redhat.com>
References: <54BBA6E4.7020506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48870 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbbARMaA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 18 Jan 2015 07:30:00 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0ICTxCm013671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2015 07:29:59 -0500
Received: from [10.10.52.144] (vpn-52-144.rdu2.redhat.com [10.10.52.144])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0ICTxHZ021674
	for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2015 07:29:59 -0500
In-Reply-To: <54BBA6E4.7020506@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 01/18/2015 07:28 AM, Tony Camuso wrote:
>
> Of course, disabling 64-bit kernel in .config removes the problem, but this is
>     an unacceptable solution.
  ^^^
  NOT

