From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: OP_PHISOURCE's phi_users
Date: Wed, 30 Nov 2016 22:51:02 +0100
Message-ID: <20161130215102.GA5604@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:36362 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbcK3VvG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Nov 2016 16:51:06 -0500
Received: by mail-wj0-f179.google.com with SMTP id qp4so188054968wjc.3
        for <linux-sparse@vger.kernel.org>; Wed, 30 Nov 2016 13:51:06 -0800 (PST)
Received: from macbook.local (180.52-241-81.adsl-dyn.isp.belgacom.be. [81.241.52.180])
        by smtp.gmail.com with ESMTPSA id f67sm9934550wmd.13.2016.11.30.13.51.04
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2016 13:51:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi list,

struct instruction has a field, 'phi_users', used for OP_PHISOURCE
to store their users. In other words this field is used to store the
OP_PHIs instruction that use a given OP_PHISOURCE.

I'm wondering if someone would have an example where an OP_PHISOURCE
is used by more than one OP_PHI.

I've searched, not too hard but still and I didn't found any.
To be honest, I don't think it can happen and if it does I'm wondering
what would be the associated meaning.


Luc 
