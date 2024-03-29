/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import id.hikari.core.dto.UserDataDTO;
import id.hikari.core.dto.UserResponseDTO;
import id.hikari.core.model.User;
import id.hikari.core.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import javax.servlet.http.HttpServletRequest;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
@Api(tags = "users")
public class UserController {

    @Autowired
    private UserService userService;

    private ModelMapper modelMapper;

    @PostMapping("/signin")
    @ApiOperation(value = "${UserController.signin}")
    @ApiResponses(value = {//

        @ApiResponse(code = 400, message = "Something went wrong")
        , //
      @ApiResponse(code = 422, message = "Invalid username/password supplied")})
    public ResponseEntity login(//
            @ApiParam("Username") @RequestParam String username, //
            @ApiParam("Password") @RequestParam String password) {
        return ResponseEntity.ok(userService.signin(username, password));
    }

    @PostMapping("/signup")
    @ApiOperation(value = "${UserController.signup}")
    @ApiResponses(value = {//

        @ApiResponse(code = 400, message = "Something went wrong")
        , //
      @ApiResponse(code = 403, message = "Access denied")
        , //
      @ApiResponse(code = 422, message = "Username is already in use")
        , //
      @ApiResponse(code = 500, message = "Expired or invalid JWT token")})
    public ResponseEntity signup(@ApiParam("Signup User") @RequestBody UserDataDTO user) {
        User userModel = new User();
        userModel.setUsername(user.getUsername());
        userModel.setEmail(user.getEmail());
        userModel.setPassword(user.getPassword());
        userModel.setRoles(user.getRoles());
        return ResponseEntity.ok(userService.signup(userModel));
    }

    @DeleteMapping(value = "/{username}")
//    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ApiOperation(value = "${UserController.delete}")
    @ApiResponses(value = {//

        @ApiResponse(code = 400, message = "Something went wrong")
        , //
      @ApiResponse(code = 403, message = "Access denied")
        , //
      @ApiResponse(code = 404, message = "The user doesn't exist")
        , //
      @ApiResponse(code = 500, message = "Expired or invalid JWT token")})
    public String delete(@ApiParam("Username") @PathVariable String username) {
        userService.delete(username);
        return username;
    }

    @GetMapping(value = "/{username}")
//    @PreAuthorize("hasRole('ROLE_OWNER')")
    @ApiOperation(value = "${UserController.search}", response = UserResponseDTO.class)
    @ApiResponses(value = {//

        @ApiResponse(code = 400, message = "Something went wrong")
        , //
      @ApiResponse(code = 403, message = "Access denied")
        , //
      @ApiResponse(code = 404, message = "The user doesn't exist")
        , //
      @ApiResponse(code = 500, message = "Expired or invalid JWT token")})
    public User search(@ApiParam("Username") @PathVariable String username) {
        return userService.search(username);
    }

    @GetMapping(value = "/me")
//    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_CLIENT')")
    @ApiOperation(value = "${UserController.me}", response = UserResponseDTO.class)
    @ApiResponses(value = {//

        @ApiResponse(code = 400, message = "Something went wrong")
        , //
      @ApiResponse(code = 403, message = "Access denied")
        , //
      @ApiResponse(code = 500, message = "Expired or invalid JWT token")})
    public User whoami(HttpServletRequest req) {
        return userService.whoami(req);
    }
 
//    @GetMapping("/refresh")
////    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_CLIENT')")
//    public String refresh(HttpServletRequest req) {
//        return userService.refresh(req.getRemoteUser());
//    }

}
