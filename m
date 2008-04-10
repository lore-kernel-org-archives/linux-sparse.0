From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 0/3] Examples for the new sparse context tracking
	functionality
Date: Thu, 10 Apr 2008 15:48:10 +0200
Message-ID: <20080410134810.629048000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757960AbYDJOlw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-wireless@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Here are some patches that show how the new sparse functionality  
could be used in the kernel if merged.

As mentioned before, I have actually found three bugs in mac80211
using these patches. If you apply them and the sparse patches I have
also just posted, you can find them too :)

johannes
