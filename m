From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v11 01/13] compiler.h, kasan: add __SANITIZE_ADDRESS__ check for __no_kasan_or_inline
Date: Fri,  8 Jun 2018 19:09:36 +0200
Message-ID: <20180608171216.26521-2-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com, nhorman@redhat.com, npmccallum@redhat.com, Christopher Li <sparse@chrisli.org>, "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add 'defined(__SANITIZE_ADDRESS__)' to check to determine whether
__no_kasan_or_inline should be 'no_kasan' or 'inline'.  Files that
compile with KASAN disabled may not link to KASAN, in which case
the __maybe_unused attribute added in the 'no_kasan' option can
cause linker errors due to unused functions that manually invoke
KASAN functions, e.g. read_word_at_a_time(), not being discarded.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..e7a863a3ac8c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -188,7 +188,7 @@ void __read_once_size(const volatile void *p, void *res, int size)
 	__READ_ONCE_SIZE;
 }
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN) && defined(__SANITIZE_ADDRESS__)
 /*
  * We can't declare function 'inline' because __no_sanitize_address confilcts
  * with inlining. Attempt to inline it may cause a build failure.
-- 
2.17.0
