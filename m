From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: sparse warnings on undeclared asmlinkage
Date: Fri, 11 Oct 2019 17:18:58 +0100
Message-ID: <67799c6b-77c1-8488-9595-38ca734e8d5f@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

I was reviewing the sparse output for the current kernel release and
note there are a number of warnings about un-declared functions which
are only used for code in assembly.

I was wondering if we should just ignore those, and have either a
new attribute for "undeclared is ok" or to make spare just ignore
anything with the syscall_linkage attribute?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
