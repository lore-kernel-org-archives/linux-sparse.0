From: Blaisorblade <blaisorblade@yahoo.it>
Subject: BUG: sparse redeclaration warning when assigning to a declared variable!
Date: Thu, 8 Mar 2007 18:53:15 +0100
Message-ID: <200703081853.15693.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:22929 "HELO
	smtp005.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752374AbXCHSA1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 13:00:27 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse ML <linux-sparse@vger.kernel.org>

What I saw running sparse on Linux source tree:

paolo [linux-2.6.20] $ make C=2 mm/page-writeback.o
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHECK   scripts/mod/empty.c
  CHECK   mm/page-writeback.c
mm/page-writeback.c:912:9: warning: symbol 'ret' shadows an earlier one
mm/page-writeback.c:906:6: originally declared here
mm/page-writeback.c:919:9: warning: symbol 'ret' shadows an earlier one
mm/page-writeback.c:906:6: originally declared here
mm/page-writeback.c:933:9: warning: symbol 'ret' shadows an earlier one
mm/page-writeback.c:927:6: originally declared here
mm/page-writeback.c:944:9: warning: symbol 'ret' shadows an earlier one
mm/page-writeback.c:927:6: originally declared here
  CC      mm/page-writeback.o

Code giving one of these warnings (kernel tree 2.6.20.1), other warnings are 
like this. I.e.:
ret = something()
is seen as redeclaration.

int test_set_page_writeback(struct page *page)
{
        struct address_space *mapping = page_mapping(page);
        int ret;

        if (mapping) {
                unsigned long flags;

                write_lock_irqsave(&mapping->tree_lock, flags);
                ret = TestSetPageWriteback(page);
                if (!ret)
                        radix_tree_tag_set(&mapping->page_tree,
                                                page_index(page),
                                                PAGECACHE_TAG_WRITEBACK);
                if (!PageDirty(page))
                        radix_tree_tag_clear(&mapping->page_tree,
                                                page_index(page),
                                                PAGECACHE_TAG_DIRTY);
                write_unlock_irqrestore(&mapping->tree_lock, flags);
        } else {
                ret = TestSetPageWriteback(page);
        }
        return ret;

}

Tested with both sparse v0.2 and my git HEAD, where I get:

sparse.git $ git-describe
0.2-41-g309f380

Bye
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
