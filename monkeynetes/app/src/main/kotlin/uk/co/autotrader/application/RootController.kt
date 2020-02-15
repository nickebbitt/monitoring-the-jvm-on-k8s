package uk.co.autotrader.application

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/")
class RootController
@Autowired
constructor() {

    @GetMapping
    fun hello(): ResponseEntity<String> {
        return ResponseEntity.ok("<p>This monkey is running and ready to cause some chaos. <br /><br />see <a href='https://github.atcloud.io/AutoTrader/monkeynetes'>https://github.atcloud.io/AutoTrader/monkeynetes</a> to find out how.</p>")
    }
}